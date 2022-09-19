// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50137 GLEExt extends "General Ledger Entries"
{
    actions
    {
        addafter(ReverseTransaction)
        {
            action("Update Empty")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'update empty';
                Image = MoveToNextPeriod;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Scope = Repeater;

                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::ModifyGLNo);
                end;
            }
        }
    }
}
codeunit 50136 ModifyGLNo
{
    Permissions = tabledata "G/L Entry" = rmd;
    trigger OnRun()
    var
        GLEntries: Record "G/L Entry";
    begin
        GLEntries.SetCurrentKey("Document No.");
        GLEntries.SetFilter("Document No.", '%1', 'GEN000262');
        if GLEntries.FindSet() then
            repeat
                Message(GLEntries.Description);
                GLEntries."Document No." := 'GEN000263';
                if GLEntries.Modify(true) then begin
                    Message('Successfully updatedljelr');
                end;
            until (GLEntries.Next() = 0);
    end;
}
