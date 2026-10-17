query 55004 Transporter
{
    APIGroup = 'apiGroup';
    APIPublisher = 'TechbizInfoTech';
    APIVersion = 'v1.0';
    EntityName = 'TransporterAPI';
    EntitySetName = 'TransporterAPI';
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
            column(Vendor_No_; "Vendor No.")
            {

            }
            column(Vendor_Name; "Vendor Name")
            {

            }
            column(email; email)
            {

            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
