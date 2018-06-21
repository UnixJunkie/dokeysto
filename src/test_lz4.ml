open Printf

module Rwdbz = Dokeysto_lz4.Db_lz4.RWZ
module Rodbz = Dokeysto_lz4.Db_lz4.ROZ

let n = 1_000_000

(* RWDBZ *)
let test_rwdbz () =
  let start = Unix.gettimeofday () in
  let rwz = Rwdbz.create "rwdbz" in
  for i = 1 to n do
    let s = string_of_int i in
    Rwdbz.add rwz s s
  done;
  let stop = Unix.gettimeofday () in
  printf "RWZ records creation rate: %.2f/s\n%!" (float n /. (stop -. start));
  Rwdbz.sync rwz;
  let start' = Unix.gettimeofday () in
  for i = 1 to n do
    let s = string_of_int i in
    assert(s = Rwdbz.find rwz s);
  done;
  let stop' = Unix.gettimeofday () in
  printf "RWZ records find rate: %.2f/s\n%!" (float n /. (stop' -. start'));
  let _ = Sys.command "ls -lh rwdbz rwdbz.idx" in
  Rwdbz.close rwz

(* RODBZ *)
let test_rodbz () =
  let roz = Rodbz.open_existing "rwdbz" in
  let start''' = Unix.gettimeofday () in
  for i = 1 to n do
    let s = string_of_int i in
    assert(s = Rodbz.find roz s);
  done;
  let stop''' = Unix.gettimeofday () in
  printf "ROZ records find rate: %.2f/s\n%!" (float n /. (stop''' -. start'''))

let () =
  test_rwdbz ();
  test_rodbz ()
