table 55045 "Standard Rate Charges Setup"
{
    Caption = 'Standard Rate Charges Setup';
    DataClassification = ToBeClassified;



    fields
    {

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement = True;
        }
        field(3; "Charges Code"; Code[20])
        {
            Caption = 'Charge Code';
            DataClassification = ToBeClassified;
            TableRelation = Item;
            trigger OnValidate()
            var
                AddChg: Record "Standard Rate Charges Setup";
            begin
                AddChg.Reset();
                AddChg.SetRange("Charges Code", Rec."Charges Code");
                if AddChg.FindFirst() then
                    Error('Item No. %1 already exist for the container ID', Rec."Charges Code");
            end;
        }
        field(4; Rate; Decimal)
        {
            Caption = 'Rate';
            DataClassification = ToBeClassified;
        }

        field(6; "Wash Type"; Option)
        {
            OptionMembers = ,Cold,Steam;
            trigger OnValidate()
            begin
                rec.TestField("Empty Container Wash");
            end;
        }
        field(7; "Empty Container Wash"; boolean)
        {

        }
        field(8; "Kephis Charge"; Boolean)
        {

        }
        field(5; "Empty Container Repositioning"; Boolean)
        {

        }
        field(9; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }

    }
    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
}


