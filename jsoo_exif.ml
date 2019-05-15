open Js_of_ocaml.Js

let wrap_lwt f current_args =
  let (rv, cb) = Lwt.task () in
  let _ = f (Array.append current_args [|Unsafe.inject (fun x -> Lwt.wakeup_later cb x)|]) in
  rv


module Img = struct
  type t

  let of_data_uri s =
    wrap_lwt
      (Unsafe.fun_call
        (Unsafe.js_expr "imgOfString"))
      [| Unsafe.inject s |]

  let to_data_uri t =
    wrap_lwt
      (Unsafe.fun_call
        (Unsafe.js_expr "stringOfImg"))
      [| Unsafe.inject t |]

  let to_file t =
    wrap_lwt
      (Unsafe.fun_call
        (Unsafe.js_expr "fileOfImg"))
      [| Unsafe.inject t |]

  let of_file t =
    wrap_lwt
      (Unsafe.fun_call
        (Unsafe.js_expr "fileToImg"))
      [| Unsafe.inject t |]
end

let get_data img tag =
  wrap_lwt
    (Unsafe.fun_call
      (Unsafe.js_expr "getData"))
    [|  Unsafe.inject img
    ;   Unsafe.inject tag |]

let get_orientation img =
  wrap_lwt
    (Unsafe.fun_call
      (Unsafe.js_expr "getOrientation"))
    [| Unsafe.inject img |]

let reorient_image img =
  wrap_lwt
    (Unsafe.fun_call
      (Unsafe.js_expr "reorientImage"))
    [| Unsafe.inject img |]
