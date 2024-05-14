import os
import uuid
import pandas as pd
import glob
import numpy as np
import datetime


#
# List all files in a directory and throw an error if the directory is empty.
#
def list_files_in_directory(input_folder) -> list:
    # Get list of all files in the input_folder
    files = glob.glob(os.path.join(input_folder, '*.xlsx'))

    # Throw an error if the directory is empty
    if len(files) == 0:
        raise ValueError(f"No files found in {input_folder}")

    # Return only the filenames, not the full path
    filenames = [os.path.basename(file) for file in files]

    return filenames


#
# Load an Excel file and convert each sheet into a DataFrame.
# Return a dictionary where each key is the sheet name and the corresponding value is the DataFrame.
#
def load_excel_to_dict(folder, file) -> dict:
    # Get full path to file
    file_path = os.path.join(folder, file)

    # Check if the input file exists
    if not os.path.exists(file_path):
        print(f"File not found: {file_path}")
        return None

    # Load spreadsheet
    xl = pd.ExcelFile(file_path)

    # Load the entire Excel file into a dictionary of DataFrames
    xl_dict = pd.read_excel(xl, sheet_name=None)

    return xl_dict


#
# Create foldername with current timestamp
#
# main_folder + '/' + filename + '/' + start_date.strftime('%Y/%m/%d/%H/%M/%S')
def create_foldername(main_folder, filename) -> str:
    # Create foldername with current timestamp
    foldername = os.path.join(main_folder,
                              filename,
                              datetime.datetime.now().strftime('%Y/%m/%d/%H/%M/%S'))

    return foldername



#
# Save a dictionary of DataFrames into Parquet files in a specified output folder.
# Each key in the dictionary will be used as the name of the Parquet file.
#
def save_dict_to_parquet(xl_dict, output_folder):
    # Create folder for output (if it doesn't exist yet)
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    # Convert all non-numeric columns to string 
    for key in xl_dict:
        # Convert all non-numeric columns to string
        for col in xl_dict[key].select_dtypes(exclude=['int64', 'float64']).columns:
            xl_dict[key][col] = xl_dict[key][col].astype(str)

        # Convert all UUID columns to string
        for column in xl_dict[key].columns:
            if xl_dict[key][column].apply(lambda x: isinstance(x, uuid.UUID)).any():
                xl_dict[key][column] = xl_dict[key][column].astype(str)

        # Save each DataFrame to a parquet file in the output folder
        xl_dict[key].to_parquet(f"{output_folder}/{key}.parquet", index=False)


#
# Folders have the following structure:
#      base_folder / YYYY / MM / DD / HH / MM / SS
#
def find_latest_folder(base_folder) -> str:
    # Get list of all folders in the base_folder
    folders = glob.glob(os.path.join(base_folder, '*/*/*/*/*/*'))

    # Throw an error if the directory is empty
    if len(folders) == 0:
        raise ValueError(f"No folders found in {base_folder}")

    # Sort folders by name (which is a timestamp)
    folders.sort()

    # Return the last folder
    return folders[-1]


#
# Load all the parquet files in a directory
#
def load_parquet_files(input_folder):
    # Get list of all parquet files in the injestion_files directory
    parquet_files = glob.glob(os.path.join(input_folder, '*.parquet'))

    # Initialize an empty dictionary to hold dataframes
    dataframes = {}

    # Load each Parquet file into a DataFrame and add it to the dictionary
    for file in parquet_files:
        # Read the parquet files, ensuring the nan are converted to NaN
        df = pd.read_parquet(file, engine='pyarrow')

        # Replace all empty strings with np.nan
        df.replace('nan', np.nan, inplace=True)

        # Use the filename without extension as dictionary key
        key = os.path.splitext(os.path.basename(file))[0]
        dataframes[key] = df

    return dataframes


#
# Save a dictionary of DataFrames into CSV files in a specified output folder.
# Each key in the dictionary will be used as the name of the CSV file.
#
def save_dict_to_csv(xl_dict, output_folder):
    # Create folder for output (if it doesn't exist yet)
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    # Save each DataFrame to a CSV file in the output folder
    for key in xl_dict:
        # Save DataFrame to a CSV file with ',' as decimal separator
        xl_dict[key].to_csv(f"{output_folder}/{key}.csv", index=False, sep=';', decimal=',')

        # Open the CSV file and replace 'nan' and 'NaT' with ''
        with open(f"{output_folder}/{key}.csv", 'r') as file:
            filedata = file.read()

        # Replace the target string
        filedata = filedata.replace('nan', '').replace('NaT', '')

        # Write the file out again
        with open(f"{output_folder}/{key}.csv", 'w') as file:
            file.write(filedata)

        print(f"Saved {key}.csv")

#
# Load an Excel file and convert a specific sheet into a DataFrame.
#
def load_excel_sheet_to_dataframe(folder, file, sheet_name, rows_to_skip) -> pd.DataFrame:
    # Get full path to file
    file_path = os.path.join(folder, file)

    # Check if the input file exists
    if not os.path.exists(file_path):
        print(f"File not found: {file_path}")
        return None

    # Load spreadsheet
    xl = pd.ExcelFile(file_path)

    # Check if the sheet exists in the Excel file
    if sheet_name not in xl.sheet_names:
        print(f"Sheet '{sheet_name}' not found in '{file}'. Available sheets: {xl.sheet_names}")
        return None

    # Load the specified sheet into a DataFrame
    df = pd.read_excel(xl, sheet_name=sheet_name, skiprows=rows_to_skip)

    return df
