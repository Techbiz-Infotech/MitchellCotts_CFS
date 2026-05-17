report 50054 "Update IMS"
{
    Caption = 'Update IMS';
    UsageCategory = ReportsAndAnalysis;

    ProcessingOnly = True;
    ApplicationArea = All;
    dataset
    {
        dataitem("Charge ID Assignment"; "Charge ID Assignment")
        {
            DataItemTableView =
                where(
                    Status = const(Released),
                    "Charge Id Group Code" = filter('N25*'));
            trigger OnAfterGetRecord()
            begin

                "Effective To Date" := DMY2Date(15, 04, 2026);
                Modify();
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
}
