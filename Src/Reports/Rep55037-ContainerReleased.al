report 55027 "Container Released"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Container Movement Delivered';
    ApplicationArea = All;
    ProcessingOnly = true;
    UseRequestPage = true;



    dataset
    {
        dataitem("Manifest Line"; "Manifest Line")
        {
            DataItemTableView = SORTING("Job File No.") where("Shortcut Dimension 3 Code" = filter('CONTAINER'), Released = const(true));
            RequestFilterFields = "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code";
            trigger OnPreDataItem()
            begin
                SETFILTER("Date Released", '%1..%2', StartDate, EndDate);

            end;

            trigger OnAfterGetRecord()
            begin
                // ManifestHead.Reset();
                // ManifestHead.SetRange("Job File No.", "Manifest Line"."Job File No.");
                // if ManifestHead.FindFirst() then;

                ReceivLog.Reset();
                ReceivLog.SetRange("Shortcut Dimension 4 Code", "Manifest Line"."Shortcut Dimension 4 Code");
                if ReceivLog.FindSet() then;

                postedGateOutLine.Reset();
                postedGateOutLine.SetRange("Shortcut Dimension 4 Code", "Manifest Line"."Shortcut Dimension 4 Code");
                if postedGateOutLine.FindFirst() then;
                //Create Body or Line Part
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
        ReceivLog: Record ReceivingLog;
        //ManifestHead: Record "Manifest Header";
        postedGateOutLine: Record "Posted Gate Pass out Line";

    local procedure MakeHeader()
    var
        myInt: Integer;
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Container Released', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('From' + ' ' + Format(StartDate) + '....' + 'ToDate' + '' + Format(EndDate), false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Sr.No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Container Number', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('BL No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Weight', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('CBM', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('ICDN In-Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Description', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Truck No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Transporter', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('VesselVoyage', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('ETA', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Manifest Number', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Destination', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Received Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Released Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Consignee Name', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Gate pass No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure MakeBody()
    var
        myInt: Integer;
    begin
        SNo := SNo + 1;
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(SNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

        TempExcelBuffer.AddColumn("Manifest Line"."Container/Chassis No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."BL No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line".Weight, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."CBM Tonage", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."ICDN In-Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn("Manifest Line".Description, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

        TempExcelBuffer.AddColumn(postedGateOutLine."Truck No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn(postedGateOutLine."Tranporter/Driver Name", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."Vessel Name", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn("Manifest Line"."Expected Arrival Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn("Manifest Line"."Manifest No", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn("Manifest Line"."Destination Type", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn("Manifest Line"."Date Received", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn("Manifest Line"."Date Released", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn("Manifest Line"."Consignee Name", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn("Manifest Line"."Seal/Engine No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn("PostedGateOutLine"."Gate Pass No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
    end;



    local procedure CreateExcelBook()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        FileName: Text;
    begin
        TempExcelBuffer.CreateNewBook('Container Released Report');
        TempExcelBuffer.WriteSheet('Container Released Report', CompanyName, UserId);
        TempExcelBuffer.CloseBook();

        TempBlob.CreateOutStream(OutStr);
        TempExcelBuffer.SaveToStream(OutStr, true);
        TempBlob.CreateInStream(InStr);

        FileName := 'Container Released Report.xlsx';
        DownloadFromStream(InStr, '', '', '', FileName);
    end;

    var
        SICDStorageDays: Integer;


}