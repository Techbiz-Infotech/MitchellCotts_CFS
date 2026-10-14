report 55018 "DO Reconciliation"
{
    Caption = 'DO Reconciliation';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;
    dataset
    {
        dataitem("Manifest Line"; "Manifest Line")
        {
            DataItemTableView = SORTING("Job File No.") where(Released = const(true));
            trigger OnPreDataItem()
            begin
                SETFILTER("Date Released", '%1..%2', StartDate, EndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                // "ManifestHead".Reset();
                // "ManifestHead".SetRange("Job File No.", "Manifest Line"."Job File No.");
                // if "ManifestHead".FindFirst() then;
                GatepassLine.Reset();
                GatepassLine.SetRange("Shortcut Dimension 4 Code", "Manifest Line"."Shortcut Dimension 4 Code");
                if GatepassLine.FindSet() then;
                MakeBody;
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
    // ManifestHead: Record "Manifest Header";

    local procedure MakeHeader()
    var
        myInt: Integer;
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('DO Reconciliation', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        //TempExcelBuffer.AddColumn('From' + ' ' + Format(StartDate) + '....' + 'ToDate' + '' + Format(EndDate), false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(' Released Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('BL Number', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Gatepass Number', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('DO Number', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('DO Expiry Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Shipping Line Confirmation', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Shipping Line', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

    end;

    local procedure MakeBody()
    var
        myInt: Integer;
    begin

        SNo := SNo + 1;
        TempExcelBuffer.NewRow();

        TempExcelBuffer.AddColumn("Manifest Line"."Date Released", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(GatepassLine."BL No", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GatepassLine."Gate Pass No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn(GatepassLine."Delivery Order No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GatepassLine."DO No. Expiry date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn("Manifest Line"."Shipping Agent Name", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);


        //"Manifest Line".CalcFields();
        // TempExcelBuffer.AddColumn("Sales Invoice Header".Amount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
    end;

    Local procedure CreateExcelBook();
    begin
        TempExcelBuffer.CreateNewBook('DO Reconciliation Report');
        TempExcelBuffer.WriteSheet('DO Reconciliation Report', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('DO Reconciliation Report');
        TempExcelBuffer.OpenExcel();
    end;
}
