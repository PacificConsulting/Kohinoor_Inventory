pageextension 50403 ItemTrackEntriesExt extends "Item Tracking Lines"
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
        modify("Select Entries")
        {
            trigger OnAfterAction()
            var
                ILE: Record 32;
            begin
                ILE.RESET;
                ILE.SETRANGE("Lot No.", Rec."Lot No.");
                IF ILE.FINDFIRST THEN BEGIN
                    Rec."Sr. No. Posting Date" := ILE."Sr. No. Posting Date";
                    Rec.Modify();
                END;
            end;
        }
    }

    var
        myInt: Integer;
}