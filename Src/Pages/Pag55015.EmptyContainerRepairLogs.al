page 55015 "Empty Container Repair Logs"
{
    ApplicationArea = All;
    Caption = 'Empty Container Repair Logs';
    PageType = List;
    SourceTable = VerificationLog;
    SourceTableView = SORTING("Entry No.") ORDER(Descending) where("Repair Posted" = const(True));
    //Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = History;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Repair Date"; Rec."Repair Date")
                {
                    ToolTip = 'Specifies the value of the Verification Date field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Repair Time"; Rec."Repair Time")
                {
                    ToolTip = 'Specifies the value of the Verification Time field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job File No."; rec."Job File No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Container No./Chassis No."; rec."Container No./Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Container Type"; Rec."Container Type")
                {
                    ToolTip = 'Specifies the value of the Container Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the  field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Container  field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Container  field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Repair Type"; Rec."Repair Type")
                {
                    ToolTip = 'Specifies the value of the Verification Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Shipper Seal"; Rec."Shipper Seal")
                {
                    ToolTip = 'Specifies the value of the Shipper Seal field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                //field()
                field("User ID"; rec."User ID")
                {

                    ToolTip = 'Specifies the value of the Start After field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("New Seal"; rec."New Seal")
                {
                    ToolTip = 'Specifies the value of the New Seal field.';
                    ApplicationArea = All;
                    Editable = VELogEditable;
                }
                field(Invoiced; Rec.Invoiced)
                {
                    ToolTip = 'Specifies the value of the Invoiced field.';
                    ApplicationArea = All;
                    Editable = VELogEditable;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("Additional Charges")
            {
                Caption = 'Additional Charges';
                ApplicationArea = All;
                RunObject = page "Additional Charges";
                RunPageLink = "Container ID" = field("Shortcut Dimension 4 Code");
            }


        }
    }
    var
        VELogEditable: Boolean;

    trigger OnOpenPage()
    var
    begin
        VerificationLogEditable();
    end;

    trigger OnAfterGetRecord()
    var
    begin
        VerificationLogEditable();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        VerificationLogEditable();
    end;

    trigger OnAfterGetCurrRecord()
    var
    begin
        VerificationLogEditable();
    end;

    procedure VerificationLogEditable()
    var
        Usersetup: Record "User Setup";

    begin
        UserSetup.get(UserId);
        if not UserSetup."Verification Log Edit" then
            VELogEditable := false
        else
            VELogEditable := true;
    end;
}

