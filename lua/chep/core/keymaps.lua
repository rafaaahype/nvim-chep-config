-- F5 COMPILADOR / LIVE SERVER
vim.keymap.set("n","<F5>",function()
  if vim.bo.filetype == "dashboard" then return end
  if vim.bo.buftype == "" then vim.cmd("write") end

  local ft = vim.bo.filetype

  if ft == "html" then
    vim.cmd("LiveServerStart")
    print("ei moral o live server ta aberto viu, da uma olhada no brave")
    return
  end

  vim.cmd("belowright split | resize 12")
  local cmd = ""

  if vim.fn.filereadable("Makefile") == 1 then
    cmd = "make && ./main"

  elseif ft == "c" or ft == "cpp" then
    local uses_raylib = vim.fn.system("grep -r \"raylib\" .") ~= ""

    if ft == "c" then
      if uses_raylib then
        cmd = "gcc *.c -o main -lraylib -lm -ldl -lpthread -lX11 && ./main"
      else
        cmd = "gcc *.c -o main && ./main"
      end
    elseif ft == "cpp" then
      if uses_raylib then
        cmd = "g++ *.cpp -o main -lraylib -lm -ldl -lpthread -lX11 && ./main"
      else
        cmd = "g++ *.cpp -o main && ./main"
      end
    end

  elseif ft == "python" then 
    print("programa em python foi compilado moral")
    cmd = "python3 " .. vim.fn.expand("%")

  elseif ft == "odin" then
  	print("programa em odin foi compilado moral")
	cmd = "odin run *.odin -file"
  elseif ft == "lua" then
	print("programa em lua foi compilado moral")
	cmd = "lua *.lua" 
end

  if cmd ~= "" then
    vim.cmd("terminal " .. cmd)
    vim.cmd("startinsert")
  end
end)
