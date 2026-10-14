report 55043 "Monthly Report MV"
{
    ApplicationArea = All;
    Caption = 'Monthly Report MV';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/layouts/MonthlyReportMV.rdlc';
    dataset
    {
        dataitem(ManifestLine; "Manifest Line")
        {
            column(JobFileDate; "Job File Date")
            {
            }
            column(JobFileNo; "Job File No.")
            {
            }
            column(receivedDate; "Date Received")
            {
            }
            column(MonthYear; Format("Date Received", 0, '<Month Text> <Year>'))
            {

            }
            column(VesselArrivalDate; "Vessel Arrival Date")
            {
            }
            column(VesselArrivalTime; "Vessel Arrival Time")
            {
            }
            column(VesselName; "Vessel Name")
            {
            }
            column(VoyageNo; "Voyage No.")
            {
            }
            column(BLNo; "BL No.")
            {
            }
            column(ContainerChassisNo; "Container/Chassis No.")
            {
            }
            column(NoofBags; "No. of Bags")
            {
            }
            column(Weight; Weight)
            {
            }
            column(CBMTonage; "CBM Tonage")
            {
            }
            column(ShippingAgent; "Shipping Agent")
            {
            }
            column(ShippingAgentName; "Shipping Agent Name")
            {
            }
            column(ConsigneeName; "Consignee Name")
            {
            }
            column(ConsigneeNo; "Consignee No.")
            {
            }

            trigger OnPreDataItem()
            begin
                if (StartDate <> 0D) and (EndDate <> 0D) then
                    SetRange("Date Received", StartDate, EndDate)
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Filter by Date")
                {
                    Caption = 'Filter by Date';

                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
}