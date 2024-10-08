#!/bin/bash

while true; do
    clear
    echo "-------------------Menu-----------------------------"
    echo "[1] List the contents of a folder"
    echo "[2] Create a text file with a line of text"
    echo "[3] Compare two text files"
    echo "[4] awk"
    echo "[5] grep"
    echo "[6] Exit"
    echo "----------------------------------------------------"
    read -p "Select an option: " option

    case $option in
        1)
            read -p "Enter the absolute path of the folder: " folderPath
            if [ -d "$folderPath" ]; then
                ls "$folderPath"
            else
                echo "The file does not exist."
            fi
            ;;
        2)
            read -p "Enter the text string to store in the file: " text
            read -p "Enter the path of the file to create: " filePath
            echo "$text" > "$filePath"
            echo "File created successfully."
            ;;
        3)
            read -p "Enter the path of the first file: " firstPath
            read -p "Enter the path of the second file: " secondPath

            if [ -f "$firstPath" ] && [ -f "$secondPath" ]; then
                firstFile=$(cat "$firstPath")
                secondFile=$(cat "$secondPath")

                if [ "$firstFile" == "$secondFile" ]; then
                    echo "The contents of the files are the same."
                else
                    echo "The contents of the files are different."
                fi
            else
                echo "One or both files do not exist."
            fi
            ;;
        4)
            read -p "Enter the path of the file to use with awk: " filePath
            if [ -f "$filePath" ]; then
                echo "Choose an action:"
                echo "[1] Print first column"
                echo "[2] Count lines containing a pattern"
                read -p "Select an action: " awkOption
                case $awkOption in
                    1)
                        awk '{print $1}' "$filePath"
                        ;;
                    2)
                        read -p "Enter the pattern to search for: " awkPattern
                        awk -v pattern="$awkPattern" '$0 ~ pattern {count++} END {print count}' "$filePath"
                        ;;
                    *)
                        echo "Invalid option."
                        ;;
                esac
            else
                echo "The file '$filePath' does not exist."
            fi
            ;;
        5)
            read -p "Enter the path of the file to use with grep: " filePath
            read -p "Enter the pattern to search for: " pattern
            if [ -f "$filePath" ]; then
                echo "Choose an action:"
                echo "[1] Display matching lines"
                echo "[2] Count occurrences"
                read -p "Select an action: " grepOption
                case $grepOption in
                    1)
                        grep "$pattern" "$filePath"
                        ;;
                    2)
                        grep -c "$pattern" "$filePath"
                        ;;
                    *)
                        echo "Invalid option."
                        ;;
                esac
            else
                echo "The file '$filePath' does not exist."
            fi
            ;;
        6)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
    read -p "Press enter to continue..."
done

