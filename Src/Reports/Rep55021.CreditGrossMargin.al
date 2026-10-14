report 55021 "Credit Gross Margin"
{
    Caption = 'Cargo Gross Margin';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/layouts/CreditGrossMargin.rdlc';

    dataset
    {
        dataitem("Manifest Line"; "Manifest Line")
        {
            DataItemTableView = where("Charge ID" = filter(<> ''), Received = filter(True), Released = filter(False), Invoices = filter(True));
            RequestFilterFields = "Global Dimension 1 Code", "Date Received", "Shortcut Dimension 4 Code";
            column(GlobalDimension1Code_ManifestLine; "Container/Chassis No.")
            {
            }
            column(Companylogo; CompanyInfo.Picture) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            { }
            column(Shortcut_Dimension_3_Code; "Shortcut Dimension 3 Code") { }
            column(CargoType; "Shortcut Dimension 4 Code") { }
            column(Shortcut_Dimension_5_Code; "Shortcut Dimension 5 Code") { }
            column(Shortcut_Dimension_6_Code; "Shortcut Dimension 6 Code") { }
            column(ConsigneeNo_ManifestLine; "Consignee Name")
            {
            }
            column(Date_Received; "Date Received") { }
            column(Job_File_Date; "Job File Date") { }
            column(ClearingAgent_ManifestLine; "Clearing Agent")
            {
            }
            column(BLNo_ManifestLine; "BL No.")
            {
            }


            column(Net_Profit; NetProfit)
            {
            }

            trigger OnAfterGetRecord()
            var
                GLEntry: Record "G/L Entry";
                CreditGrossMarginRec: Record "Credit Gross Margin";
                RevenueTotal: Decimal;
                ExpenseTotal: Decimal;
            begin
                RevenueTotal := 0;
                ExpenseTotal := 0;
                NetProfit := 0;

                CreditGrossMarginRec.Reset();
                if CreditGrossMarginRec.FindSet() then
                    repeat
                        GLEntry.Reset();
                        GLEntry.SetRange("Shortcut Dimension 4 Code", "Shortcut Dimension 4 Code");
                        GLEntry.SetRange("G/L Account No.", CreditGrossMarginRec."G/L Account");
                        if GLEntry.FindSet() then
                            repeat
                                case CreditGrossMarginRec.Type of
                                    CreditGrossMarginRec.Type::"Storage Account":
                                        RevenueTotal += ABS(GLEntry.Amount);

                                    CreditGrossMarginRec.Type::"Var Cost Account":
                                        ExpenseTotal += ABS(GLEntry.Amount);
                                end;
                            until GLEntry.Next() = 0;

                    until CreditGrossMarginRec.Next() = 0;

                NetProfit := RevenueTotal - ExpenseTotal;
                if NetProfit > 0 then CurrReport.Skip();
            end;
        }
    }
    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture)
    end;

    var
        NetProfit: Decimal;
        CompanyInfo: Record "Company Information";

}