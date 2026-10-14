pageextension 55050 PurchaseInvoiceSubformExt extends "Purch. Invoice Subform"
{
    layout
    {
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
            begin
                UpdateDimensionFields();

            end;
        }
        modify(ShortcutDimCode4)
        {
            Visible = false;

        }
        addafter(Description)
        {
            field("Description of goods"; rec."Description of goods")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the description of goods';
            }
        }
        addafter("Shortcut Dimension 1 Code")
        {
            field("BL No"; Rec."BL No")
            {
                ApplicationArea = All;
                trigger OnLookup(var text: text): Boolean
                var
                    ManiLine: Record "Manifest Line";
                begin

                    ManiLine.Reset();
                    ManiLine.SetRange("Container lock", false);
                    ManiLine.SetRange(Received, false);
                    ManiLine.SetRange(Manifested, true);
                    ManiLine.SetRange(Verified, false);
                    ManiLine.SetRange(Released, false);
                    if page.RunModal(0, ManiLine) = Action::LookupOK then
                        Rec."BL No" := ManiLine."BL No.";
                end;
            }
            field("Shortcut Dimension 4 Code"; rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = all;
                trigger OnLookup(var text: text): Boolean
                var
                    ManiLine: Record "Manifest Line";
                begin
                    Rec.TestField("BL No");
                    ManiLine.Reset();
                    ManiLine.SetRange("Container lock", false);
                    ManiLine.SetRange(Received, false);
                    ManiLine.SetRange(Manifested, true);
                    ManiLine.SetRange(Verified, false);
                    ManiLine.SetRange(Released, false);
                    ManiLine.SetRange("BL No.", Rec."BL No");
                    if page.RunModal(0, ManiLine) = Action::LookupOK then begin
                        Rec."Shortcut Dimension 4 Code" := ManiLine."Shortcut Dimension 4 Code";
                        UpdateDimensionFields();

                        //CurrPage.Update(false);
                    end;
                end;


            }

        }


    }
    procedure UpdateDimensionFields()
    var
        ManifestLine: Record "Manifest Line";
        PurchaseLineSubform: Page "Purch. Invoice Subform";
        PurchaseLine: Record "Purch. Inv. Line";
        ImsSetup: Record "IMS Setup";
    begin
        ImsSetup.Get();
        ManifestLine.Reset();
        ManifestLine.SetRange("shortcut Dimension 4 Code", Rec."Shortcut Dimension 4 Code");
        if ManifestLine.FindFirst() then begin
            if ImsSetup."KPA Receive Manditory" then
                if not ManifestLine.Received then
                    Error('This container %1 is not received', ManifestLine."Shortcut Dimension 4 Code");
            Rec."Shortcut Dimension 2 Code" := ManifestLine."Global Dimension 2 Code";
            Rec."Shortcut Dimension 1 Code" := ManifestLine."Global Dimension 1 Code";
            ShortcutDimCode[3] := ManifestLine."Shortcut Dimension 3 Code";
            ShortcutDimCode[4] := ManifestLine."Shortcut Dimension 4 Code";
            ShortcutDimCode[5] := ManifestLine."Shortcut Dimension 5 Code";
            ShortcutDimCode[6] := ManifestLine."Shortcut Dimension 6 Code";
            ShortcutDimCode[1] := ManifestLine."Global Dimension 1 Code";
            rec.ValidateShortcutDimCode(2, rec."Shortcut Dimension 2 Code");
            rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
            Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
            Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
            Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
            Rec.ValidateShortcutDimCode(1, ShortcutDimCode[1]);


        end else
            Error('Container %1 could not be found', Rec."Shortcut Dimension 4 Code");
    end;
}
