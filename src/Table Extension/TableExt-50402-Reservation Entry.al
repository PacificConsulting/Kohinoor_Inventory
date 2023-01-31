tableextension 50402 ReservEntryExt extends "Reservation Entry"
{
    fields
    {
        field(50401; "Sr. No. Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}