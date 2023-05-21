-- Get the text between square brackets on the current line
local function get_text_between_square_brackets()
    -- Get the current line under the cursor
    local line_content = get_line_under_cursor()
  
    -- Find the starting and ending positions of all square brackets
    local start_pos, end_pos = string.find(line_content, "%b[]", 1, true)
  
    -- Find the position of the cursor
    local cursor_pos = vim.fn.col(".")
  
    -- Keep track of the closest square bracket positions
    local closest_start_pos, closest_end_pos
  
    -- Iterate over all square brackets on the line
    while start_pos do
      -- Check if the cursor is between the square brackets
      if start_pos <= cursor_pos and cursor_pos <= end_pos then
        -- Check if the square brackets are immediately followed by a URL pattern
        local url_start_pos, url_end_pos = string.find(line_content, "%b()", end_pos + 1)
        if url_start_pos and url_end_pos then
          local url_content = string.sub(line_content, url_start_pos + 1, url_end_pos - 1)
          return url_content
        else
          break
        end
      end
  
      -- Find the next square bracket positions
      start_pos, end_pos = string.find(line_content, "%b[]", end_pos + 1, true)
    end
  
    return nil
  end
  
  -- Example usage
  local text_between_brackets = get_text_between_square_brackets()
  print(text_between_brackets)
  

-- Define a mapping to call the function and replace the current window's content
vim.api.nvim_set_keymap('n', '<F5>', [[<Cmd>lua local output = get_text_between_square_brackets() if output then vim.fn.system('md-browse --url=' .. output) end<CR>]], { noremap = true, silent = true })
