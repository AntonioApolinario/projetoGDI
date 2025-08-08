import psycopg2
import pandas as pd
from pandasgui import show
import tkinter as tk
from functools import partial

def conectar():
    return psycopg2.connect(
        dbname="postgres",
        user="postgres",
        password="postgres",
        host="localhost",
        port=5432
    )

consultas = {
    "1": {
        "titulo": "Quantos ninjas de Konoha existem? (GROUP BY / HAVING)",
        "sql": """
            SELECT
                NOME_ALDEIA,
                COUNT(*)
            FROM
                NINJA
            GROUP BY
                NOME_ALDEIA
            HAVING
                NOME_ALDEIA = 'Konoha';
        """
    },
    "2": {
        "titulo": "Quem são os Jounins? (Junção interna)",
        "sql": """
            SELECT
                N.PRIMEIRO_NOME
            FROM
                JOUNIN J
            INNER JOIN
                NINJA N ON N.RG_NINJA = J.RG_NINJA;
        """
    },
    "3": {
        "titulo": "Todos os ninjas e quais têm biju (Junção externa)",
        "sql": """
            SELECT
                N.*
            FROM
                NINJA N
            LEFT JOIN
                BIJU B ON N.RG_NINJA = B.RG_NINJA;
        """
    },
    "4": {
        "titulo": "Ninjas que têm jutsu rank S (Semi-junção)",
        "sql": """
            SELECT
                PRIMEIRO_NOME
            FROM
                NINJA
            WHERE
                RG_NINJA IN (
                    SELECT
                        RG_NINJA
                    FROM
                        JUTSU
                    WHERE
                        RANK = 'S'
                );
        """
    },
    "5": {
        "titulo": "Ninjas que NÃO têm biju (Anti-junção)",
        "sql": """
            SELECT
                N.*
            FROM
                NINJA N
            LEFT JOIN
                BIJU B ON N.RG_NINJA = B.RG_NINJA
            WHERE
                B.RG_NINJA IS NULL;
        """
    },
    "6": {
        "titulo": "Missões com recompensa acima da média (Subconsulta escalar)",
        "sql": """
            SELECT
                DESCRICAO,
                RECOMPENSA
            FROM
                MISSAO
            WHERE
                RECOMPENSA > (
                    SELECT
                        AVG(RECOMPENSA)
                    FROM
                        MISSAO
                );
        """
    },
    "7": {
        "titulo": "Ninjas que moram e tem o mesmo clã do ninja de rg = '000000006' (Subconsulta linha)",
        "sql": """
            SELECT
                N.PRIMEIRO_NOME,
                N.CODINOME
            FROM
                NINJA N
            WHERE
                (N.NOME_CLA, N.NOME_ALDEIA) = (
                    SELECT
                        NOME_CLA,
                        NOME_ALDEIA
                    FROM
                        NINJA
                    WHERE
                        RG_NINJA = '000000006'
                );
        """
    },
    "8": {
        "titulo": "Ninjas com mais jutsus (Subconsulta tabela)",
        "sql": """
            SELECT
                N.PRIMEIRO_NOME,
                J.QTD_JUTSUS
            FROM
                NINJA N
            JOIN (
                SELECT
                    RG_NINJA,
                    COUNT(*) AS QTD_JUTSUS
                FROM
                    JUTSU
                GROUP BY
                    RG_NINJA
                HAVING
                    COUNT(*) = (
                        SELECT
                            MAX(QTD)
                        FROM (
                            SELECT
                                COUNT(RG_NINJA) AS QTD
                            FROM
                                JUTSU
                            GROUP BY
                                RG_NINJA
                        ) AS SUB
                    )
            ) J ON N.RG_NINJA = J.RG_NINJA;
        """
    },
    "9": {
        "titulo": "Todos os nomes de ninjas e bijus (UNION)",
        "sql": """
            SELECT
                PRIMEIRO_NOME AS NOME
            FROM
                NINJA
            UNION
            SELECT
                NOME
            FROM
                BIJU;
        """
    }
}


def executar_consulta(key):
    try:
        conn = conectar()
        sql = consultas[key]["sql"]
        titulo = consultas[key]["titulo"]
        df = pd.read_sql(sql, conn)
        df.name = titulo
        show(df)
    except Exception as e:
        print(f"❌ Erro na consulta: {e}")
    finally:
        if 'conn' in locals():
            conn.close()

def criar_interface():
    root = tk.Tk()
    root.title("Consultas - Projeto Naruto")

    tk.Label(root, text="Selecione uma consulta:", font=("Arial", 14, "bold")).pack(pady=10)

    for key in sorted(consultas.keys()):
        titulo = consultas[key]['titulo']
        btn = tk.Button(root, text=f"{key} - {titulo}", width=60, anchor="w",
                        command=partial(executar_consulta, key))
        btn.pack(padx=10, pady=2)

    tk.Label(root, text="Janela permanece aberta para novas consultas.", font=("Arial", 10)).pack(pady=10)

    root.mainloop()

if __name__ == "__main__":
    criar_interface()
