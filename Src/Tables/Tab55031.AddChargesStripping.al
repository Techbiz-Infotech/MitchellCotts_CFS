table 55031 AdditionalChargesStripping
{
    Caption = 'Additional Charges - Stripping';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Container ID"; Code[20])
        {
            Caption = 'Container ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Stripping Type"; Enum "Stripping TypeEnum")
        {
            Caption = 'Stripping Type';
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
            ObsoleteReason = 'As per client request';

        }
        field(4; "Stripping Charges"; Decimal)
        {
            Caption = 'Stripping Charges';
            DataClassification = ToBeClassified;
        }
        field(5; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
    }
    keys
    {
        key(PK; "Container ID", "Line No.")
        {
            Clustered = true;
        }
    }
}
