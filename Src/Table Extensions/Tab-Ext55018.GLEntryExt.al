tableextension 55018 "GL Entry Ext" extends "G/L Entry"
{
    fields
    {
        field(50100; "Prepayment Reversed"; Boolean)
        {
            Caption = 'Prepayment Reversed';
            DataClassification = ToBeClassified;
        }
        field(50101; "IMS Document Type"; Enum IMSDocTypeEnum)
        {
            Caption = 'IMS Document Type';
            DataClassification = ToBeClassified;
        }
    }
}
