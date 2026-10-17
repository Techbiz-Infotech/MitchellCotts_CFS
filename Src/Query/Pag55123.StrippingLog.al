page 55123 StrippingLog
{
    APIGroup = 'apiGroup';
    APIPublisher = 'Techbizinfotech';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'strippingLog';
    DelayedInsert = true;
    EntityName = 'StrippingAPI';
    EntitySetName = 'StrippingAPI';
    PageType = API;
    SourceTable = StrippingLog;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(blNo; Rec."BL No.")
                {
                    Caption = 'BL No.';
                }
                field(containerNoChassisNo; Rec."Container No./Chassis No.")
                {
                    Caption = 'Container No./Chassis No.';
                }
                field(containerType; Rec."Container Type")
                {
                    Caption = 'Container Type';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(invoiced; Rec.Invoiced)
                {
                    Caption = 'Invoiced';
                }
                field(jobFileNo; Rec."Job File No.")
                {
                    Caption = 'Job File No.';
                }
                field(shipperSeal; Rec."Shipper Seal")
                {
                    Caption = 'Shipper Seal';
                }
                field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    Caption = 'Shortcut Dimension 4 Code';
                }
                field(shortcutDimension5Code; Rec."Shortcut Dimension 5 Code")
                {
                    Caption = 'Shortcut Dimension 5 Code';
                }
                field(strippingDate; Rec."Stripping Date")
                {
                    Caption = 'Stripping Date';
                }
                field(strippingNo; Rec."Stripping No.")
                {
                    Caption = 'Stripping No.';
                }
                field(strippingNotes; Rec."Stripping Notes")
                {
                    Caption = 'Stripping Notes';
                }
                field(strippingTime; Rec."Stripping Time")
                {
                    Caption = 'Stripping Time';
                }
            }
        }
    }
}
