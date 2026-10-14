report 55037 "Container Movement"
{
    ApplicationArea = All;
    Caption = 'Container Movement';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(ManifestLine; "Manifest Line")
        {
            DataItemTableView = sorting("Date Received") where("Shortcut Dimension 5 Code" = filter('20FT|40FT'), Received = const(true));
            RequestFilterFields = "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Shortcut Dimension 6 Code";

            trigger OnPreDataItem()
            var
                MLine: Record "Manifest Line";
            begin
                // loop through every day from Start Date to End Date
                CurrDate := StartDate;
                while CurrDate <= EndDate do begin
                    // Received that day
                    MLine.Reset();
                    MLine.CopyFilters(ManifestLine);
                    MLine.SetRange(Received, true);
                    MLine.SetRange("Date Received", CurrDate);
                    MLine.SetRange("Shortcut Dimension 5 Code", '20FT');
                    Rec20 := MLine.Count();
                    MLine.SetRange("Shortcut Dimension 5 Code", '40FT');
                    Rec40 := MLine.Count();

                    // Released that day
                    MLine.Reset();
                    MLine.CopyFilters(ManifestLine);
                    MLine.SetRange(Released, true);
                    MLine.SetRange("Date Released", CurrDate);
                    MLine.SetRange("Shortcut Dimension 5 Code", '20FT');
                    Rel20 := MLine.Count();
                    MLine.SetRange("Shortcut Dimension 5 Code", '40FT');
                    Rel40 := MLine.Count();

                    // only write days with movement
                    if (Rec20 + Rec40 + Rel20 + Rel40) <> 0 then
                        MakeBody();

                    CurrDate := CurrDate + 1;
                end;

                CurrReport.Break(); // counting is done; no need to loop the lines
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
    }

    trigger OnPreReport()
    begin
        if StartDate = 0D then
            Error('Please enter a Start Date.');
        if EndDate = 0D then
            Error('Please enter an End Date.');
        if StartDate > EndDate then
            Error('Start Date cannot be greater than End Date.');

        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        MakeHeader();
    end;

    trigger OnPostReport()
    begin
        CreateExcelBook();
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        StartDate: Date;
        EndDate: Date;
        CurrDate: Date;
        Rec20, Rec40, Rel20, Rel40 : Integer;

    local procedure MakeHeader()
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('MITCHELL COTTS STOCK REPORT', FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('From ' + Format(StartDate) + ' To ' + Format(EndDate), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Date', FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Received', FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Released', FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('20''', FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('40''', FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total', FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('TEUs', FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('20''', FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('40''', FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total', FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('TEUs', FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure MakeBody()
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(CurrDate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(Rec20, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Rec40, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Rec20 + Rec40, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Rec20 + (Rec40 * 2), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Rel20, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Rel40, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Rel20 + Rel40, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Rel20 + (Rel40 * 2), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
    end;

    // local procedure CreateExcelBook()
    // begin
    //     TempExcelBuffer.CreateNewBook('Container Movement');
    //     TempExcelBuffer.WriteSheet('Container Movement', CompanyName, UserId);
    //     TempExcelBuffer.CloseBook();
    //     TempExcelBuffer.SetFriendlyFilename('Container Movement Report');
    //     TempExcelBuffer.OpenExcel();
    // end;

    local procedure CreateExcelBook()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        FileName: Text;
    begin
        TempExcelBuffer.CreateNewBook('Container Movement');
        TempExcelBuffer.WriteSheet('Container Movement', CompanyName, UserId);
        TempExcelBuffer.CloseBook();

        TempBlob.CreateOutStream(OutStr);
        TempExcelBuffer.SaveToStream(OutStr, true);
        TempBlob.CreateInStream(InStr);

        FileName := 'Container Movement Report.xlsx';
        DownloadFromStream(InStr, '', '', '', FileName);
    end;
}