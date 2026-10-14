tableextension 55000 ShippingAgent extends "Shipping Agent"
{
    fields
    {
        field(50050; email; Code[100])
        {
            Caption = 'email';
            DataClassification = ToBeClassified;
        }
        field(50051; email2; Code[100])
        {
            Caption = ' Second email';
            DataClassification = ToBeClassified;
        }
    }
}
