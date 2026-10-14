report 55019 "Daily Yard Stock"
{
    Caption = 'Daily Yard Stock';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;
    dataset
    {
        dataitem(DateLoop; Date)
        {
            column(CurrentDateCol; "Period Start") { }
            column(Received40FTCount; received40FT) { }
            column(Received20FTCount; received20FT) { }
            column(StartDateCol; StartDate) { }
            column(EndDateCol; EndDate) { }

            trigger OnPreDataItem()
            begin
                // Generates one row per day
                // 25,26,27,28 = exactly 4 rows
                SetRange("Period Type", "Period Type"::Date);
                SetRange("Period Start", StartDate, EndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                // Reset counts for each day
                received40FT := 0;
                Received20FT := 0;
                TotalContainersRecvd := 0;
                TotalTeus := 0;
                Delivered20FT := 0;
                Delivered40FT := 0;
                TotalContainersDeL := 0;
                TotalTeusDel := 0;
                stock20ft := 0;
                stock40ft := 0;
                stockcontainers := 0;
                stockteus := 0;

                // COUNT received on this day
                ManifestLine.Reset();
                ManifestLine.SetRange(
                    Received, true);
                ManifestLine.SetRange("Date Received", "Period Start");
                ApplyDimensionFilters();

                if ManifestLine.FindSet() then begin
                    if ManifestLine."Shortcut Dimension 5 Code" = '20FT' THEN
                        Received20FT := ManifestLine.Count();
                    IF ManifestLine."Shortcut Dimension 5 Code" = '40FT' then
                        received40FT := ManifestLine.Count();
                    TotalContainersRecvd := Received20FT + received40FT;
                    TotalTeus := Received20FT + (received40FT * 2);
                end;

                // COUNT released on this day
                ManifestLine.Reset();
                ManifestLine.SetRange(
                    Released, true);
                ManifestLine.SetRange(
                    "Date Released", "Period Start");
                ApplyDimensionFilters();

                if ManifestLine.FindSet() then begin
                    if ManifestLine."Shortcut Dimension 5 Code" = '20FT' THEN
                        Delivered20FT := ManifestLine.Count();
                    IF ManifestLine."Shortcut Dimension 5 Code" = '40FT' then
                        Delivered40FT := ManifestLine.Count();
                    TotalContainersDeL := Delivered20FT + Delivered40FT;
                    TotalTeusDel := Delivered20FT + (Delivered40FT * 2);
                end;


                // COUNT in stock on this day
                // Received = true AND Released = false
                ManifestLine.Reset();
                ManifestLine.SetRange(
                    Received, true);
                ManifestLine.SetRange(
                    Released, false);
                ManifestLine.SetRange(
                    "Date Received", StartDate, "Period Start");
                ApplyDimensionFilters();
                if ManifestLine.FindSet() then begin
                    if ManifestLine."Shortcut Dimension 5 Code" = '20FT' THEN
                        stock20ft := ManifestLine.Count();
                    IF ManifestLine."Shortcut Dimension 5 Code" = '40FT' then
                        stock40ft := ManifestLine.Count();
                    stockcontainers := stock20ft + stock40ft;
                    stockteus := stock20ft + (stock40ft * 2);
                end;
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
                group(DimensionFilters)
                {
                    Caption = 'Dimension Filters';

                    field(Dim3Filter; FilterDim3)
                    {
                        ApplicationArea = All;
                        Caption = 'Shortcut Dimension 3';
                        ToolTip = 'Filter by Shortcut Dimension 3 Code. Leave blank to include all.';
                        TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                    }
                    field(Dim4Filter; FilterDim4)
                    {
                        ApplicationArea = All;
                        Caption = 'Shortcut Dimension 4';
                        ToolTip = 'Filter by Shortcut Dimension 4 Code. Leave blank to include all.';
                        TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
                    }
                    field(Dim5Filter; FilterDim5)
                    {
                        ApplicationArea = All;
                        Caption = 'Container Type (Dim. 5)';
                        ToolTip = 'Filter by Container Type: 20FT or 40FT. Leave blank to include all.';
                        TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
                    }
                    field(Dim6Filter; FilterDim6)
                    {
                        ApplicationArea = All;
                        Caption = 'Shortcut Dimension 6';
                        ToolTip = 'Filter by Shortcut Dimension 6 Code. Leave blank to include all.';
                        TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));
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
        MakeHeader; //Create Header Part
    end;

    trigger OnPostReport()
    begin
        CreateExcelBook; // Create Excel Book
    end;

    var
        Received20FT, received40FT, TotalContainersRecvd, TotalTeus, Delivered20FT, Delivered40FT,
    TotalContainersDeL, TotalTeusDel, stock20ft, stock40ft, stockcontainers, stockteus : integer;
        StartDate: Date;
        FilterDim3: Code[20];
        FilterDim4: Code[20];
        FilterDim5: Code[20];
        FilterDim6: Code[20];
        EndDate: Date;
        ManifestLine: record "Manifest Line";
        TempExcelBuffer: Record "Excel Buffer" temporary;

    local procedure MakeHeader()
    var
        myInt: Integer;
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Daily Yard Stock', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        //TempExcelBuffer.AddColumn('From' + ' ' + Format(StartDate) + '....' + 'ToDate' + '' + Format(EndDate), false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Received 20FT', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Received 40FT', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total Rcvd Containers', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total Rcvd TEUS', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Delivered 20FT', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Delivered 40FT', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total Delivered Containers', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total Delivered TEUS', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Stock 20FT', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Stock 40FT', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total Stock', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total Stock TEUS', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

    end;

    local procedure ApplyDimensionFilters()
    begin
        if FilterDim3 <> '' then
            ManifestLine.SetRange("Shortcut Dimension 3 Code", FilterDim3);
        if FilterDim4 <> '' then
            ManifestLine.SetRange("Shortcut Dimension 4 Code", FilterDim4);
        if FilterDim5 <> '' then
            ManifestLine.SetRange("Shortcut Dimension 5 Code", FilterDim5);
        if FilterDim6 <> '' then
            ManifestLine.SetRange("Shortcut Dimension 6 Code", FilterDim6);
    end;

    local procedure MakeBody()
    var
        myInt: Integer;
    begin


        TempExcelBuffer.NewRow();

        TempExcelBuffer.AddColumn(DateLoop."Period Start", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(Received20FT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(received40FT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn(TotalContainersRecvd, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TotalTeus, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Delivered20FT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn(Delivered40FT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TotalContainersDeL, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TotalTeusDel, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(stock20ft, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn(stock40ft, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(stockcontainers, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn(stockteus, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);





        //"Manifest Line".CalcFields();
        // TempExcelBuffer.AddColumn("Sales Invoice Header".Amount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
    end;

    Local procedure CreateExcelBook();
    begin
        TempExcelBuffer.CreateNewBook('Daily Yard Stock Report');
        TempExcelBuffer.WriteSheet('Daily Yard Report Stock', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Daily Yard Stock Report');
        TempExcelBuffer.OpenExcel();
    end;
}
