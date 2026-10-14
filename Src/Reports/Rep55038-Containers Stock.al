report 55038 "Container Stock"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Container Stock';
    ApplicationArea = All;
    ProcessingOnly = true;
    UseRequestPage = true;


    dataset
    {
        dataitem("Manifest Line"; "Manifest Line")
        {
            DataItemTableView = SORTING("Job File No.") where("Shortcut Dimension 3 Code" = filter('CONTAINER'), Received = const(true));
            RequestFilterFields = "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code";

            trigger OnPreDataItem()
            begin
                "Manifest Line".SetRange("Date Received", 19700101D, EndDate);
                "Manifest Line".SetFilter("Date Released", '<%1|>%2', 19700101D, EndDate);
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
        // IF StartDate = 0D THEN //Validation
        //     ERROR('Start Date must not be blank');//Validation
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
        TempExcelBuffer.AddColumn('Containers Stock As on' + '  ' + Format(EndDate), false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();

        TempExcelBuffer.AddColumn('Sr.No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Vessel', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('ETA', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Container Number', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Consignee Name', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Goods Description', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Container Size', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('BL Number', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Manifest  No', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Destination', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Received Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

        TempExcelBuffer.AddColumn('Shipping Line', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

    end;

    local procedure MakeBody()
    var
        myInt: Integer;
    begin
        SNo := SNo + 1;
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(SNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn("Manifest Line"."Vessel Name", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."Expected Arrival Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn("Manifest Line"."Container/Chassis No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."Consignee Name", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn("Manifest Line".Description, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn("Manifest Line"."Container Size", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."BL No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."Manifest No", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."Final Destination", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."Date Received", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn("Manifest Line"."Shipping Agent", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
    end;

    local procedure CreateExcelBook()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        FileName: Text;
    begin
        TempExcelBuffer.CreateNewBook('Container Stock');
        TempExcelBuffer.WriteSheet('Container Stock', CompanyName, UserId);
        TempExcelBuffer.CloseBook();

        TempBlob.CreateOutStream(OutStr);
        TempExcelBuffer.SaveToStream(OutStr, true);
        TempBlob.CreateInStream(InStr);

        FileName := 'Container Stock Report.xlsx';
        DownloadFromStream(InStr, '', '', '', FileName);
    end;

    var
        TotalDays: Integer;
        SICDStorageDays: Integer;


}