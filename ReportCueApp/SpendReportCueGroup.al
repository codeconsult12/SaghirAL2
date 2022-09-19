///////////////////Cue Group Table and Role Center Extension/////////////////////////////
table 50101 Cue
{
    //DataClassification = ToBeClassified;
    fields
    {
        field(1; CueID; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Purchase Journals"; Integer)
        {
            Access = Public;
            FieldClass = FlowField;
            CalcFormula = count("Gen. Journal Line" where("Document Type" = filter(Invoice), "Account No." = const('V*')));
        }
        field(3; "General Journal"; Integer)
        {
            Access = Public;
            FieldClass = FlowField;
            CalcFormula = count("Gen. Journal Line" where("Document Type" = filter(" ")));
        }
        field(4; "Payment Journal"; Integer)
        {
            Access = Public;
            FieldClass = FlowField;
            CalcFormula = count("Gen. Journal Line" where("Document Type" = filter(Payment)));
        }
    }
    keys
    {
        key(PK; CueID)
        {
            Clustered = true;
        }
    }
}
page 50102 "Unposted Cues"
{
    PageType = CardPart;
    SourceTable = Cue;
    UsageCategory = Lists;
    ApplicationArea = all;
    Caption = '';
    layout
    {
        area(Content)
        {
            cuegroup(PurchaseJournalCueContainer)
            {
                Caption = '';
                //CuegroupLayout = Wide;
                field("Purchase Journals"; "Purchase Journals")
                {
                    Caption = 'Purchase Journals';
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Journal";
                    DrillDown = false;
                }
                field("General Journal"; "General Journal")
                {
                    Caption = 'General Journals';
                    ApplicationArea = all;
                    DrillDownPageId = "General Journal";
                }
                field("Payment Journal"; "Payment Journal")
                {
                    Caption = 'Payment Journals';
                    ApplicationArea = All;
                    DrillDownPageId = "Payment Journal";
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert();
        end;
    end;

}

pageextension 50103 "Bus. Role Center Ext" extends "Business Manager Role Center"
{
    layout
    {
        /*      modify(Control16)
              {
                  Visible = false;
              }
              addafter(Control16)
              {
                  part(Cue; "Unposted Cues")
                  {
                      ApplicationArea = all;
                  }
              }
          */
    }
    actions
    {
        addafter("Excel Reports")
        {
            action("Vendor Spend Report")
            {
                Caption = 'Vendor Spend Report - All Companies';
                Image = Report2;
                Promoted = true;
                PromotedCategory = Report;
                RunObject = report "Vendors Spend Report";
                ApplicationArea = All;
            }
        }
    }
}

//////////////////////////Cue Group End//////////////////////

///////////////////////////Vendor Spend Report/////////////////////////////////
// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

report 50124 "Vendors Spend Report"
{
    UsageCategory = ReportsAndAnalysis;
    AdditionalSearchTerms = 'vendor, spend';
    ApplicationArea = All;
    DefaultLayout = RDLC;


    RDLCLayout = 'SpendReport.rdl';

    dataset
    {
        dataitem(Company; Company)
        {
            DataItemTableView = where(Name = filter('Ancora Innovation, LLC' | 'Blackfan Circle Inn, LLC' | 'Blue One Biosciences, LLC' | 'Blue Q Biosciences LLC' |
'Bluefield Innovations, LLC' | 'Deerfield BI, LLC' | 'Deerfield D?D, LLC' | 'Exohalt Therapeutics, LLC' | 'Four Points Innovation LLC' | 'Galium Biosciences LLC' |
'Hudson Heights Innovations LLC' | 'Lab1636, LLC' | 'Lakeside Discovery, LLC' | 'Orchard Innovations, LLC' | 'Pinnacle Hill, LLC' | 'Poseidon Innovation, LLC' |
'West Loop Innovations, LLC'));
            column(Name; Name) { }
            dataitem(VLE; "Vendor Ledger Entry")
            {
                column(filter; VLE.GetFilters()) { }
                column(Vendor_No_; "Vendor No.") { }
                column(Amount; Amount) { }
                dataitem(Vendor; Vendor)
                {
                    DataItemLink = "No." = Field("Vendor No.");
                    //                    SqlJoinType = InnerJoin;
                    column(VendorName; Name) { }
                }
                trigger OnPreDataItem()

                begin
                    SetFilter("Document Type", '%1', "Document Type"::Invoice);
                end;


                trigger OnAfterGetRecord()
                begin
                    //Vendor.ChangeCompany(CompanyName);
                end;
            }
            //          trigger OnPreDataItem()
            //        begin
            //                Company.SetFilter(Name, '=%1|=%2', 'ABC', '');
            //              if Company.FindSet() then
            //                repeat
            //                  message(Name);
            //                VLE.ChangeCompany(Name);
            //              Vendor.ChangeCompany(Name);
            //        until Company.Next() = 0;
            //message(Name);
            //if
            //(Name <> 'ABC')

            //                then begin
            //    message(Name);
            //    VLE.ChangeCompany(Name);
            //    Vendor.ChangeCompany(Name);

            //      end;

            trigger OnAfterGetRecord()
            begin
                //            Message(Name);
                //          if Name = 'ABC' then begin
                //            Message(Name);
                VLE.ChangeCompany(Name);
                Vendor.ChangeCompany(Name);
            end;
            //end;
            //begin


        }
    }
}

