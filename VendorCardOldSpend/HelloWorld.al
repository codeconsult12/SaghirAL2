// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

tableextension 50141 VendTableExt extends Vendor
{
    fields
    {
        field(50100; "Prior Payments"; Decimal)
        {

        }
    }
}

pageextension 50142 VendCardExt extends "Vendor Card"
{

    layout
    {
        addafter("Balance Due (LCY)")
        {
            field("Prior Payments"; "Prior Payments")
            {
                ApplicationArea = all;

            }
        }
    }
}