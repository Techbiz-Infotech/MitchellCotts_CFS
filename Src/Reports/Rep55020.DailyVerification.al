report 55020 "Daily Verification"
{
    Caption = 'Daily Verification Report';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;


    dataset
    {
        dataitem("Manifest Line"; "Manifest Line")
        {
            DataItemTableView = SORTING("Job File No.") where(Verified = const(true));
            trigger OnPreDataItem()
            begin
                SETFILTER("Verification Print Date", '%1..%2', StartDate, EndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                // "ManifestHead".Reset();
                // "ManifestHead".SetRange("Job File No.", "Manifest Line"."Job File No.");
                // if "ManifestHead".FindFirst() then;
                VerificationLogrec.Reset();
                VerificationLogrec.SetRange("Shortcut Dimension 4 Code", "Manifest Line"."Shortcut Dimension 4 Code");
                if VerificationLogrec.FindSet() then;
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
        VerificationLogrec: Record VerificationLog;
        ReceivLog: Record ReceivingLog;
    // ManifestHead: Record "Manifest Header";

    local procedure MakeHeader()
    var
        myInt: Integer;
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Daily Verification Report', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        //TempExcelBuffer.AddColumn('From' + ' ' + Format(StartDate) + '....' + 'ToDate' + '' + Format(EndDate), false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Container No', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('BL No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Size', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Verification Type', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Clearing Agent', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Client', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Original Seal', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Final Seal', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Remarks', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

    end;

    local procedure MakeBody()
    var
        myInt: Integer;
    begin

        SNo := SNo + 1;
        TempExcelBuffer.NewRow();

        TempExcelBuffer.AddColumn(VerificationLogrec."Verification Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(VerificationLogrec."Container No./Chassis No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(VerificationLogrec."BL No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(VerificationLogrec."Shortcut Dimension 5 Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn(VerificationLogrec."Verification Type", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."Clearing Agent", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."Consignee Name", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(VerificationLogrec."Shipper Seal", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(VerificationLogrec."New Seal", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn(VerificationLogrec."Verification Notes", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);


        //"Manifest Line".CalcFields();
        // TempExcelBuffer.AddColumn("Sales Invoice Header".Amount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
    end;

    Local procedure CreateExcelBook();
    begin
        TempExcelBuffer.CreateNewBook('Daily Verification Report');
        TempExcelBuffer.WriteSheet('Daily Verification Report', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Daily Verification Report');
        TempExcelBuffer.OpenExcel();
    end;
}
