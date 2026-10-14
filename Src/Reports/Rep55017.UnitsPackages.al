report 55017 Units_Packages
{
    ApplicationArea = All;
    Caption = 'Units_Packages';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;
    dataset
    {
        dataitem(ManifestLine; "Manifest Line")
        {
            RequestFilterFields = "Global Dimension 1 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 4 Code", "Shortcut Dimension 6 Code";
            column(CustomEntryNo; "Custom Entry No.")
            {
            }
            column(DestinationType; "Destination Type")
            {
            }
            column(DateReceived; "Date Received")
            {
            }
            column(DateReleased; "Date Released")
            {
            }
            column(ShortcutDimension5Code; "Shortcut Dimension 5 Code")
            {
            }
            column(BLNo; "BL No.")
            {
            }
            column(DaysinYard; DaysinYard)
            {

            }
            column(Shipping_Agent_Name; "Shipping Agent Name") { }
            column(Expected_Arrival_Date; "Expected Arrival Date") { }
            trigger OnPreDataItem()
            begin
                SETFILTER("Date Received", '%1..%2', StartDate, EndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                DaysinYard := 0;
                if "Date Released" = 0D then
                    DaysinYard := Today - "Date Received"
                else
                    DaysinYard := "Date Released" - "Date Received";
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
                group(DateRange)
                {
                    Caption = 'Date Range';

                    field(StartDateField; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Enter the start date';
                    }
                    field(EndDateField; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'Enter the end date';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DELETEALL();
        if StartDate = 0D then
            Error('Please enter a Start Date.');
        if EndDate = 0D then
            Error('Please enter an End Date.');
        if StartDate > EndDate then
            Error('Start Date cannot be greater than End Date.');
        MakeHeader;
    end;

    trigger OnPostReport()
    begin
        CreateExcelBook; // Create Excel Book
    end;

    var
        DaysinYard: Integer;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        StartDate: Date;
        EndDate: Date;


    local procedure MakeHeader()
    var
        myInt: Integer;
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Units_Packages', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        //TempExcelBuffer.AddColumn('From' + ' ' + Format(StartDate) + '....' + 'ToDate' + '' + Format(EndDate), false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Shipping Line', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('ETA', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Date Received', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Container/Chassis No', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Seal No', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Consignee', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Description', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Size', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('BL Number', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Customs Entry No', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Verification Findings', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Days In Yard', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Local/Transit', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Manifest No', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Release Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

    end;

    local procedure MakeBody()
    var
        myInt: Integer;
    begin


        TempExcelBuffer.NewRow();

        TempExcelBuffer.AddColumn(ManifestLine."Shipping Agent Name", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine."Expected Arrival Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(ManifestLine."Date Received", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(ManifestLine."Container/Chassis No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine."Seal/Engine No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine."Consignee Name", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn(ManifestLine.Description, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine."Shortcut Dimension 5 Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine."BL No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine."Custom Entry No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn(ManifestLine."Verification Notes", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn(DaysinYard, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine."Destination Type", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn(ManifestLine."Manifest No", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine."Date Released", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);






        //"Manifest Line".CalcFields();
        // TempExcelBuffer.AddColumn("Sales Invoice Header".Amount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
    end;

    Local procedure CreateExcelBook();
    begin
        TempExcelBuffer.CreateNewBook('Units_Packages');
        TempExcelBuffer.WriteSheet('Units_Packages', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Units_Packages');
        TempExcelBuffer.OpenExcel();
    end;
}
