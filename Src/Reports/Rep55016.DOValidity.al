report 55016 "DO Validity"
{
    Caption = 'DO Validity';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;
    dataset
    {
        dataitem("Clearing Agent"; "Clearing Agent")
        {
            RequestFilterFields = "Clearing Agent Name", "Clearing Agent Code";


            trigger OnAfterGetRecord()
            begin
                // "ManifestHead".Reset();
                // "ManifestHead".SetRange("Job File No.", "Manifest Line"."Job File No.");
                // if "ManifestHead".FindFirst() then;
                GatepassLine.Reset();
                GatepassLine.SetRange("Clearing Agent", "Clearing Agent"."Clearing Agent Code");
                GatepassLine.SetRange("Activity Date", StartDate, EndDate);
                if GatepassLine.FindSet() then begin
                    Noofcont := GatepassLine.Count();
                    if Noofcont = 0 then
                        CurrReport.Skip();
                    MakeBody;
                end;
            end;

        }


    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    // field(ContainerID;ContainerID)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'ContainerID';
                    //     TableRelation = Dimension Value;
                    // }
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'End Date';
                    }

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }

    }
    trigger OnPreReport()
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DELETEALL();
        IF StartDate = 0D THEN //Validation
            ERROR('Start Date must not be blank');//Validation
        IF EndDate = 0D THEN //Validation
            ERROR('End Date must not be blank');//Validation
        MakeHeader; //Create Header Part
    end;

    trigger OnPostReport()
    begin
        CreateExcelBook; // Create Excel Book
    end;

    var
        SNo: Integer;
        StartDate: Date;
        EndDate: Date;
        CustomerNo: Code[250];
        TempExcelBuffer: Record "Excel Buffer" temporary;
        GatepassLine: Record "Gate Pass Out Line";
        ReceivLog: Record ReceivingLog;
        Noofcont: integer;
    // ManifestHead: Record "Manifest Header";

    local procedure MakeHeader()
    var
        myInt: Integer;
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('DO Validity', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        //TempExcelBuffer.AddColumn('From' + ' ' + Format(StartDate) + '....' + 'ToDate' + '' + Format(EndDate), false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(' Released Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Clearing Agent', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('No of Containers', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Size', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('DO Expiry Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Remarks', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

    end;

    local procedure MakeBody()
    var
        myInt: Integer;
    begin

        SNo := SNo + 1;
        TempExcelBuffer.NewRow();

        TempExcelBuffer.AddColumn(GatepassLine."Activity Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(GatepassLine."Clearing Agent", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Noofcont, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn(GatepassLine."Shortcut Dimension 5 Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GatepassLine."DO No. Expiry date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(GatepassLine.Remarks, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);


        //"Manifest Line".CalcFields();
        // TempExcelBuffer.AddColumn("Sales Invoice Header".Amount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
    end;

    Local procedure CreateExcelBook();
    begin
        TempExcelBuffer.CreateNewBook('DO Validity');
        TempExcelBuffer.WriteSheet('DO Validity', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('DO Validity');
        TempExcelBuffer.OpenExcel();
    end;
}
