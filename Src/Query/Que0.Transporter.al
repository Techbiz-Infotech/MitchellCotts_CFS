query 55004 Transporter
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    EntityName = 'entityName';
    EntitySetName = 'entitySetName';
    QueryType = API;

    elements
    {
        dataitem(transporter; Transporter)
        {
            column(Transporter_Code; "Transporter Code")
            {

            }
            column(Transporter_Name; "Transporter Name")
            {

            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
