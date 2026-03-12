import pandas as pd

# 1. LOAD THE DATA
# This tells Python to go into your 'data' folder and grab your Excel file
file_path = 'data/raw_data.xlsx'
df = pd.read_excel(file_path)

print("--- Original Data ---")
print(df)

# 2. CLEAN THE DATA
# This removes any rows that have empty cells (like the one we left empty on purpose)
df_cleaned = df.dropna()

# 3. SAVE THE CLEAN DATA
# This creates a NEW Excel file so we don't ruin the original one
output_path = 'data/cleaned_sales_data.xlsx'
df_cleaned.to_excel(output_path, index=False)

print("\n--- Success! ---")
print(f"Cleaned data saved to: {output_path}")
print("Rows with empty values have been removed.")