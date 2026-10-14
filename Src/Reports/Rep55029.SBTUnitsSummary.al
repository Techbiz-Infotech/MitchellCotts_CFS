report 55029 "SBT Units Summary"
{
    ApplicationArea = All;
    Caption = 'SBT Units Summary';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/SBTUnitsSummary.rdlc';
    dataset
    {
        dataitem(ManifestLine; "Manifest Line")
        {
            DataItemTableView = SORTING("Job File No.") where("Shortcut Dimension 3 Code" = filter('UNIT'), Received = const(true));
            RequestFilterFields = "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code";
            column(ShortcutDimension3Code; "Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code; "Shortcut Dimension 4 Code")
            {
            }
            column(TotalDelivered; TotalDelivered) { }
            column(UnitsInStock; UnitsInStock) { }
            column(Totals; Totals) { }
            trigger OnAfterGetRecord()
            var
                ManifestLines: record "Manifest Line";
            begin
                UnitsInStock := 0;
                TotalDelivered := 0;
                Totals := 0;
                ManifestLines.reset;
                ManifestLines.SetRange("Job File No.", ManifestLine."Job File No.");
                if ManifestLines.FindSet() then begin
                    if (ManifestLines.Received) and (ManifestLines.Released = False) then
                        UnitsInStock := ManifestLines.Count();

                    if ManifestLines.Released then
                        TotalDelivered := ManifestLines.Count();

                    Totals := UnitsInStock + TotalDelivered;
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
                group(GroupName)
                {
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
    var
        TotalDelivered, UnitsInStock, Totals : integer;
}
