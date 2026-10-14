page 55050 "Machine Operator List"
{
    ApplicationArea = All;
    Caption = 'Machine Operators';
    PageType = List;
    SourceTable = "Machine Operator";
    UsageCategory = Lists;
    CardPageId = "Machine Operator Card";
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Machine Operator Code"; Rec."Machine Operator Code")
                {
                    ToolTip = 'Specifies the value of the Machine Operator Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("User ID"; rec."User ID")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
}
