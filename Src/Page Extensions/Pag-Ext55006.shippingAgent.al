pageextension 55006 shippingAgent extends "Shipping Agents"
{
    layout
    {
        addafter(Name)
        {
            field(email; Rec.email)
            {
                ApplicationArea = All;

            }
            field(email2; Rec.email2)
            {
                ApplicationArea = All;
            }
        }

    }
}
