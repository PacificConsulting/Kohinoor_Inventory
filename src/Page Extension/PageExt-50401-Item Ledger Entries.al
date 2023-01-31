pageextension 50401 ItemLedgEntriesExt extends "Item Ledger Entries"
{
    layout
    {
        addbefore("Expiration Date")
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