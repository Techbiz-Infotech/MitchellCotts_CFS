page 55066 YardPositions
{
    APIGroup = 'apiGroup';
    APIPublisher = 'Techbizinfotech';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'yardPositions';
    DelayedInsert = true;
    EntityName = 'YardPositionAPI';
    EntitySetName = 'YardPositionAPI';
    PageType = API;
    InsertAllowed = false;
    ModifyAllowed = True;
    SourceTable = Position;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(positionID; Rec." Position ID")
                {
                    Caption = 'Position ID';
                }
                field(containerNoChassisNo; Rec."Container No./Chassis No.")
                {
                    Caption = 'Container No./Chassis No.';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(noSeries; Rec."No.Series")
                {
                    Caption = 'No.Series';
                }
                field(positionDescription; Rec."Position Description")
                {
                    Caption = 'Position Description';
                }
                field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    Caption = 'Shortcut Dimension 4 Code';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
            }
        }
    }
}
