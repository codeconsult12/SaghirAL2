// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50100 CustomerListExt extends "Customer Card"
{
    //    Caption='Patients';
    trigger OnOpenPage();
    begin
        if CompanyName = 'Legend' then begin
            Caption := 'Patients';
        end;
        Message('App published: Hello world');
    end;
}