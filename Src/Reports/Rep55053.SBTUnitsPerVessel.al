report 55053 "SBT Units Per Vessel"
{
    ApplicationArea = All;
    Caption = 'CFSMSA-SBT Units per Vessel';
    UsageCategory = ReportsAndAnalysis;

    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/CFSMSA-SBT Units per Vessel.rdlc';

    dataset
    {
        dataitem(ManifestLine; "Manifest Line")
        {
            column(JobFileNo; "Job File No.")
            {
            }
            column(VesselName; "Vessel Name")
            {
            }
            column(VoyageNo; "Voyage No.")
            {
            }
            column(CustomEntryNo_ManifestLine; "Custom Entry No.")
            {
            }
            column(ReceivedBy_ManifestLine; "Received By")
            {
            }
            column(DateReceived_ManifestLine; "Date Received")
            {
            }
            column(DateReleased_ManifestLine; "Date Released")
            {
            }
            column(Received_ManifestLine; Received)
            {
            }
            column(Released_ManifestLine; Released)
            {
            }
            column(ClearingAgent_ManifestLine; "Clearing Agent")
            {
            }
            column(Vehicle_ManifestLine; Vehicle)
            {
            }
            column(Verified_ManifestLine; Verified)
            {
            }
            column(FinalDestination_ManifestLine; "Final Destination")
            {
            }
            column(ContainerChassisNo_ManifestLine; "Container/Chassis No.")
            {
            }
            column(ExpectedArrivalDate; "Expected Arrival Date")
            {
            }
            column(BLNo; "BL No.")
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
            column(ShippingAgentName; "Shipping Agent Name")
            {
            }
            column(ConsigneeName; "Consignee Name")
            {
            }
            column(RepresentativePP; RepresentativePP)
            {

            }
            column(Make; Make)
            {

            }
            column(KebsRadiationCDS; KebsRadiationCDS)
            {

            }
            column(PhysicalTransferofunitstoSEZ; PhysicalTransferofunitstoSEZ)
            {

            }
            column(ReceiptbySEZOfficer; ReceiptbySEZOfficer)
            {

            }
            column(ExSEZentriestobelodged; ExSEZentriestobelodged)
            {

            }
            column(ReleasebyPGAs; ReleasebyPGAs)
            {

            }

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        RepresentativePP: code[50];
        Make: Code[50];
        KebsRadiationCDS: Code[50];
        PhysicalTransferofunitstoSEZ: Code[50];
        ReceiptbySEZOfficer: Code[50];
        ExSEZentriestobelodged: Code[50];
        ReleasebyPGAs: Code[50];



}
