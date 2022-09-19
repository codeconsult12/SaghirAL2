// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50100 RoleCenterExtAccSched extends "Business Manager Role Center"
{
    actions
    {
        addafter("Excel Reports")
        {
            action("Account Schedule")
            {
                Caption = 'Account Schedules';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                RunObject = report "Account Schedule";
                ApplicationArea = All;
            }
            action(Overview)
            {
                Caption = 'Account Schedules Overview';
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Acc. Schedule Overview";
                ApplicationArea = All;
            }
        }
    }
}