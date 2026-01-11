set pagination off
file ./test_list_int
break list_List_int_push
command 1
  print/x $rdi
  set $lp = $rdi
  x/3gx $rdi
  continue
end
break *list_List_int_push+228
command 2
  print/x $lp
  x/3gx $lp
  set $d = *(long**)$lp
  x/4gx $d
  continue
end
break list_List_int_get
command 3
  print/x $rdi
  x/3gx $rdi
  set $d = *(long**)$rdi
  x/4gx $d
  continue
end
run
quit