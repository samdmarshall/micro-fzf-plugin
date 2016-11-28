VERSION = "1.0.1"

MakeCommand("fzf", "fzf.fzf", 0)

function removeNewlines(string_value)
	if string.find(string_value, "\n") then
		return string.gsub(string_value, "\n", "")
	else
		return string_value
	end
end

function reportedExitCode(string_value)
	local exit_code_string = "exit status "
	return string.sub(string_value, 1, string.len(exit_code_string)) == exit_code_string
end

function fzf()
	CurView():Save(false)
	local fzf_output = HandleShellCommand("fzf", true, false)
	if not reportedExitCode(fzf_output) then
		local desired_path = removeNewlines(fzf_output)
		local working_path = removeNewlines(HandleShellCommand("pwd", false, false))
		local selected_path = working_path .. desired_path
		CurView():Open(selected_path)
		messenger:Message("Opened "..selected_path)
	end
end

AddRuntimeFile("fzf", "help", "help/fzf.md")
