report 55012 "Evergreen SL Stock"
{
    Caption = 'Evergreen SL Stock';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;


    dataset
    {
        dataitem("Manifest Line"; "Manifest Line")
        {
            RequestFilterFields = "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code";
            DataItemTableView = SORTING("Job File No.") where(Received = const(true), Released = const(true));
            trigger OnPreDataItem()
            begin
                SETFILTER("Date Received", '%1..%2', StartDate, EndDate);
            end;

            trigger OnAfterGetRecord()
            begin

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
        TempExcelBuffer.AddColumn('Evergreen SL Stock Report', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        //TempExcelBuffer.AddColumn('From' + ' ' + Format(StartDate) + '....' + 'ToDate' + '' + Format(EndDate), false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('BL No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Size', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Seal No', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Manifest Weight', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Date Arrived', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Date Released', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

    end;

    local procedure MakeBody()
    var
        myInt: Integer;
    begin

        SNo := SNo + 1;
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn("Manifest Line"."BL No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."Shortcut Dimension 5 Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn("Manifest Line"."Seal/Engine No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line".Weight, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."Date Received", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn("Manifest Line"."Date Released", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);


        //"Manifest Line".CalcFields();
        // TempExcelBuffer.AddColumn("Sales Invoice Header".Amount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
    end;

    Local procedure CreateExcelBook();
    begin
        TempExcelBuffer.CreateNewBook('Evergreen SL Stock Report');
        TempExcelBuffer.WriteSheet('Evergreen SL Stock Report', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Evergreen SL Stock Report');
        TempExcelBuffer.OpenExcel();
    end;
}
