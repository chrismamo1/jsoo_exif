type img

type callback = string -> unit

val img_of_string : string -> img
  [@@js.global "imgOfString"]

val get_data : callback -> img -> string -> unit
  [@@js.global "getData"]

val get_orientation : callback -> img -> unit
  [@@js.global "getOrientation"]

val reorient_image : callback -> string -> string
  [@@js.global "reorientImage"]
