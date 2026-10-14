report 55079 "Units Stock"
{
    ApplicationArea = All;
    Caption = 'Daily Units Stock';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;


    dataset
    {
        dataitem("Manifest Line"; "Manifest Line")
        {
            DataItemTableView = SORTING("Job File No.") where("Shortcut Dimension 3 Code" = filter('UNIT'), Received = const(true));
            RequestFilterFields = "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code";

            trigger OnPreDataItem()
            begin
                "Manifest Line".SetRange("Date Received", 19700101D, EndDate);
                "Manifest Line".SetFilter("Date Released", '<%1|>%2', 19700101D, EndDate);
                //SetRange(Released, false);
            end;

            trigger OnAfterGetRecord()
            begin
                // ManifestHead.Reset();
                // ManifestHead.SetRange("Job File No.", "Manifest Line"."Job File No.");
                // if ManifestHead.FindFirst() then;

                ReceivingLog.Reset();
                ReceivingLog.SetRange("Shortcut Dimension 4 Code", "Manifest Line"."Shortcut Dimension 4 Code");
                if ReceivingLog.FindSet() then;

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
                    // field(StartDate; StartDate)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Start Date';
                    // }
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
        //IF StartDate = 0D THEN //Validation
        //ERROR('Start Date must not be blank');//Validation
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
        ReceivingLog: Record ReceivingLog;
    //ManifestHead: Record "Manifest Header";

    local procedure MakeHeader()
    var
        myInt: Integer;

    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Units Stock As on' + '  ' + Format(EndDate), false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();

        TempExcelBuffer.AddColumn('Sr.No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Vessel', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('ETA', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Container/Chasis Number', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Make/Model', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('B/L Number', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Manifest No', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Consignee Name', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Local/Transit', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

        TempExcelBuffer.AddColumn('Received Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('CBM', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Weight', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Shipping Line', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure MakeBody()
    var
        myInt: Integer;
    begin
        Vehicle.get("Manifest Line".Vehicle);
        SNo := SNo + 1;
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(SNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn("Manifest Line"."Vessel Name", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."Expected Arrival Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn("Manifest Line"."Container/Chassis No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line".Vehicle, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn("Manifest Line"."BL No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."Manifest No", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."Consignee Name", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn("Manifest Line"."Process Type Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);

        TempExcelBuffer.AddColumn("Manifest Line"."Date Received", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn("Manifest Line"."CBM Tonage", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line".Weight, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

        TempExcelBuffer.AddColumn("Manifest Line"."Shipping Agent", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);


    end;

    Local procedure CreateExcelBook();
    begin
        TempExcelBuffer.CreateNewBook('Units Stock Status');
        TempExcelBuffer.WriteSheet('Units Stock Status', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Units Stock Status');
        TempExcelBuffer.OpenExcel();
    end;

    var
        Model: Integer;
        Vehicle: Record "Fixed Asset";
        SICDStorageDays: Integer;

}
