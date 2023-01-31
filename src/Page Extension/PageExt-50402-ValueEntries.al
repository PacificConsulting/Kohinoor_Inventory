pageextension 50402 ValueEntriesExt extends "Value Entries"
{
    layout
    {
        addbefore("External Document No.")
        {
            field("Sr. No. Posting Date"; Rec."Sr. No. Posting Date")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}