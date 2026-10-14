page 55017 "Standard Charges Setup"
{
    ApplicationArea = All;
    Caption = 'Standard Charges Setup';
    PageType = List;
    SourceTable = "Standard Rate Charges Setup";
    UsageCategory = Lists;
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Charges Code"; Rec."Charges Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charges Code field.';
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                    ApplicationArea = All;

                }

                field("Empty Container Wash"; Rec."Empty Container Wash")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charges Code field.';
                }
                field("Kephis Charge"; Rec."Kephis Charge")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charges Code field.';
                }
                field("Empty Container Repositioning"; Rec."Empty Container Repositioning")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charges Code field.';
                }
                field("Wash Type"; Rec."Wash Type")
                {

                }

                field(Rate; Rec.Rate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rate field.';
                }
            }
        }
    }
}

