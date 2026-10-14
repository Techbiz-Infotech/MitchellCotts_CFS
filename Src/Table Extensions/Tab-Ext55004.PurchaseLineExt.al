tableextension 55004 PurchaseLineExt extends "Purchase Line"
{
    fields
    {
        field(50100; "Description of goods"; Text[250])
        {
            Caption = 'Description of goods';
            DataClassification = ToBeClassified;
        }
        field(50200; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));

        }
        field(50201; "BL No"; code[30])
        {
            DataClassification = ToBeClassified;

        }

    }
}
