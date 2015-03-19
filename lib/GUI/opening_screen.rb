require 'tk'
require 'tkextlib/tile'
require_relative '../log_search'
require_relative '../line_match'
require_relative '../log_file_finder'

class OpeningScreen
  h = 600
  w = 600

  root = TkRoot.new
  root.title = 'Log Viewer'
  root.geometry = h.to_s + 'x' + w.to_s

  notebook = Tk::Tile::Notebook.new(root)do
    height 500
    place('height' => h, 'width' => w)
  end

  #Choose directory page \/ \/

  choose_directory = Tk::Tile::Frame.new(notebook)

  $directory = TkVariable.new
  $last_dir = TkVariable.new

  $Directory_box = Tk::Tile::Entry.new(choose_directory) {width 50; textvariable $directory}.grid( :column => 1, :row => 0, :sticky => 'we' )

  Tk::Tile::Button.new(choose_directory) {text '...'; command {insert_box}}.grid( :column => 3, :row => 0, :sticky => 'w')

  Tk::Tile::Button.new(choose_directory) {text 'Show Main Output Files'; command {show_files($directory)}}.grid( :column => 1, :row => 2, :sticky => 'w')

  notebook.add choose_directory, :text => 'Choose Directory'

  #Choose directory page /\ /\

  #Display Main Output Files page \/ \/

  display_files = Tk::Frame.new(notebook)

  $file_list = []
  $listvar = TkVariable.new($file_list)
  $list = Tk::Listbox.new(display_files) {height 5; listvariable $listvar; selectmode 'multiple'; yscrollcommand proc{|*args| $scroll.set(*args)} }.grid :column => 0, :row => 0, :sticky => 'nwes'
  $scroll = Tk::Tile::Scrollbar.new(display_files) {orient 'vertical'; command proc{|*args| $list.yview(*args)}}.grid :column => 1, :row => 0, :sticky => 'ns'
  TkGrid.columnconfigure display_files, 0, :weight => 1
  TkGrid.rowconfigure display_files, 0, :weight => 1

  Tk::Tile::Button.new(display_files) {text 'Show Call IDs'; command {show_ids($list.curselection)}}.grid( :column => 0, :row => 2, :sticky => 'w')

  notebook.add display_files, :text => 'Main Output Files', :state => 'normal'

  #Display Main Output Files page /\ /\

  #Display Call IDs page \/ \/

  call_id = Tk::Frame.new(notebook)

  $call_ids = []
  $call_id_listvar = TkVariable.new($call_ids)
  $call_id_list = Tk::Listbox.new(call_id) {height 5; listvariable $call_id_listvar; selectmode 'multiple'; yscrollcommand proc{|*args| $call_id_scroll.set(*args)} }.grid :column => 0, :row => 0, :sticky => 'nwes'
  $call_id_scroll = Tk::Tile::Scrollbar.new(call_id) {orient 'vertical'; command proc{|*args| $call_id_list.yview(*args)}}.grid :column => 1, :row => 0, :sticky => 'ns'
  TkGrid.columnconfigure call_id, 0, :weight => 1
  TkGrid.rowconfigure call_id, 0, :weight => 1

  #Tk::Tile::Button.new(call_id) {text 'Show Call IDs'; command {show_ids($call_id_list.curselection)}}.grid( :column => 0, :row => 2, :sticky => 'w')

  notebook.add call_id, :text => 'Call IDs', :state => 'normal'

  #Display Call IDs page /\ /\

end

def show_files(directory)
  log_file_finder = LogFileFinder.new(directory)
  files = log_file_finder.main_output
  num_of_files = log_file_finder.get_main_output_count
  (0..num_of_files-1).each {|i| $file_list.push(files[i]); $listvar.value = $file_list}

end

def insert_box
  $dir = root.chooseDirectory
  unless $dir == nil
    $Directory_box.delete(0, $last_dir.to_s.length)
    $Directory_box.insert(0, $dir)
  end
  $last_dir = $directory
end

def show_ids(files)
  log_search = LogSearch.new
  files.each_index { |i| returned_ids = log_search.get_call_ids($file_list[i], 'MainOutputLog');
    returned_ids.each_index { |j| $call_ids.push(returned_ids[j]); $call_id_listvar.value = $call_ids}
  }
end

OpeningScreen.new
Tk.mainloop