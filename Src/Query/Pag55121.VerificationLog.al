page 55121 VerificationLog
{
    APIGroup = 'apiGroup';
    APIPublisher = 'Techbizinfotech';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'verificationLog';
    DelayedInsert = true;
    EntityName = 'VerificationAPI';
    EntitySetName = 'VerificationAPI';
    InsertAllowed = False;
    PageType = API;
    SourceTable = VerificationLog;

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
                field(clientTypeCode; Rec."Client Type Code")
                {
                    Caption = 'Client Type Code';
                }
                field(containerNoChassisNo; Rec."Container No./Chassis No.")
                {
                    Caption = 'Container No./Chassis No.';
                }
                field(containerSize; Rec."Container Size")
                {
                    Caption = 'Container Size';
                }
                field("date"; Rec."Date")
                {
                    Caption = 'Date';
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
                field(jobFileNo; Rec."Job File No.")
                {
                    Caption = 'Job File No.';
                }
                field(processTypeCode; Rec."Process Type Code")
                {
                    Caption = 'Process Type';
                }
                field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Shortcut Dimension 3 Code';
                }
                field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    Caption = 'Shortcut Dimension 4 Code';
                }
                field(shortcutDimension5Code; Rec."Shortcut Dimension 5 Code")
                {
                    Caption = 'Shortcut Dimension 5 Code';
                }
                field(shortcutDimension6Code; Rec."Shortcut Dimension 6 Code")
                {
                    Caption = 'Shortcut Dimension 6 Code';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(verificationDate; Rec."Verification Date")
                {
                    Caption = 'Verification Date';
                }
                field(verificationNo; Rec."Verification No.")
                {
                    Caption = 'Verification No.';
                }
                field(verificationNotes; Rec."Verification Notes")
                {
                    Caption = 'Verification Notes';
                }
                field(verificationTime; Rec."Verification Time")
                {
                    Caption = 'Verification Time';
                }
                field(verificationType; Rec."Verification Type")
                {
                    Caption = 'Verification Type';
                }
            }
        }
    }
}
