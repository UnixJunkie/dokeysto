
(* values are LZ4-compressed marshaled-to-string values
   i.e. at encoding time we first marshal to string then LZ4 compress the
   marshaled value *)
module Key_LZ4val = struct

  let string_of_key (k: 'k): string =
    Marshal.(to_string k [No_sharing])

  let key_of_string (s: string): 'k =
    Marshal.from_string s 0

  let string_of_value (v: 'v): string =
    Db_lz4.compress (Marshal.(to_string v [No_sharing]))

  let value_of_string (s: string): 'v =
    Marshal.from_string (Db_lz4.uncompress s) 0

end

module ROZ = Dokeysto.Db_gen.RO (Key_LZ4val)

module RWZ = Dokeysto.Db_gen.RW (Key_LZ4val)
