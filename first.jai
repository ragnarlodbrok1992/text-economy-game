#import "Basic";
#import "Compiler";

OUTPUT_EXECUTABLE_NAME := "texteconomy";

#run {
  set_build_options_dc(.{do_output = false});

  w := compiler_create_workspace("Target Build - default");
  if !w {
      print("Workspace creation failed.\n");
      return;
  }

  target_options := get_build_options(w);
  target_options.output_executable_name = OUTPUT_EXECUTABLE_NAME;
  set_build_options(target_options, w);

  compiler_begin_intercept(w);

  add_build_file(tprint("%/src/main.jai", #filepath), w);

  message_loop();

  compiler_end_intercept(w);

  // Should get this at the end of compilation process
  print("\nDone building!\n\n");
}

message_loop :: () {
  while true {
    message := compiler_wait_for_message();

    if message.kind == {
      // Nothing here for now.
      case .COMPLETE;
        break;
    }
  }
}

