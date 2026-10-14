page 55203 "Cargo Nomination Status"
{
    ApplicationArea = All;
    Caption = 'Cargo Nomination Status';
    PageType = List;
    SourceTable = "Cargo Nomination Status";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    ApplicationArea = All;
                }
            }
        }
    }
}
