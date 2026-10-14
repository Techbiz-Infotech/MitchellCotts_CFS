page 55010 "Gross Margin Accounts"
{
    ApplicationArea = All;
    Caption = 'Gross Margin Accounts';
    PageType = List;
    SourceTable = "Credit Gross Margin";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("G/L Account"; Rec."G/L Account")
                {
                    ToolTip = 'Specifies the value of the G/L Account field.', Comment = '%';
                }
                field("G/L Description"; Rec."G/L Description")
                {
                    ApplicationArea = All;
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
            }
        }
    }
}
