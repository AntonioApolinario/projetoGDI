import psycopg2
import pandas as pd
from pandasgui import show

# Conexão com PostgreSQL Docker
def conectar():
    return psycopg2.connect(
        dbname="postgres",
        user="postgres",
        password="postgres",
        host="localhost",
        port=5432
    )

# Consultas pré-definidas
consultas = {
    "1": {
        "titulo": "Quantos ninjas de Konoha existem?",
        "sql": """
            SELECT nome_aldeia, COUNT(*) 
            FROM NINJA 
            GROUP BY nome_aldeia 
            HAVING nome_aldeia = 'Konoha';
        """
    },
    "2": {
        "titulo": "Quem são os Jounins?",
        "sql": """
            SELECT * FROM JOUNIN J JOIN NINJA N ON N.rg_ninja = J.rg_ninja;
        """
    },
    "3": {
        "titulo": "Todos os ninjas e quais têm biju (LEFT JOIN)",
        "sql": """
            SELECT * FROM NINJA n LEFT JOIN BIJU b ON n.rg_ninja = b.rg_ninja;
        """
    },
    "4": {
        "titulo": "Ninjas que têm jutsu rank S (Semi-junção)",
        "sql": """
            SELECT primeiro_nome
            FROM NINJA
            WHERE rg_ninja IN (
              SELECT rg_ninja FROM JUTSU WHERE rank = 'S'
            );
        """
    },
    "5": {
        "titulo": "Ninjas que NÃO têm biju (Anti-junção)",
        "sql": """
            SELECT * FROM NINJA N 
            LEFT JOIN BIJU B ON N.RG_NINJA = B.RG_NINJA 
            WHERE B.RG_NINJA IS NULL;
        """
    },
    "6": {
        "titulo": "Ninja com mais jutsus (subconsulta escalar)",
        "sql": """
            SELECT n.primeiro_nome, n.nome_cla,
                   (SELECT COUNT(*) 
                    FROM JUTSU j 
                    WHERE j.rg_ninja = n.rg_ninja) AS qtd_jutsus
            FROM NINJA n
            ORDER BY qtd_jutsus DESC
            LIMIT 1;
        """
    },
    "7": {
        "titulo": "Ninja com mais missões (subconsulta linha)",
        "sql": """
            SELECT *
            FROM (
                SELECT n.primeiro_nome, n.nome_aldeia
                FROM NINJA n
                JOIN NINJA_COMPOE_EQUIPE ce ON n.rg_ninja = ce.rg_ninja
                JOIN MISSAO m ON ce.equipe = m.equipe
                GROUP BY n.primeiro_nome, n.nome_aldeia
                ORDER BY COUNT(*) DESC
                LIMIT 1
            ) AS top_ninja;
        """
    },
    "8": {
        "titulo": "Ninjas com exatamente 2 jutsus (subconsulta tabela)",
        "sql": """
            SELECT *
            FROM (
                SELECT n.primeiro_nome, n.nome_cla, COUNT(j.nome) AS qtd_jutsus
                FROM NINJA n
                LEFT JOIN JUTSU j ON n.rg_ninja = j.rg_ninja
                GROUP BY n.primeiro_nome, n.nome_cla
            ) AS tabela_jutsus
            WHERE qtd_jutsus = 2;
        """
    },
    "9": {
        "titulo": "Todos os nomes de ninjas e bijus (UNION)",
        "sql": """
            SELECT primeiro_nome AS nome
            FROM NINJA
            UNION
            SELECT nome
            FROM BIJU;
        """
    }
}

# Execução principal
def main():
    print("=== CONSULTAS PRÉ-DEFINIDAS NO BANCO NARUTO ===")
    for k, v in consultas.items():
        print(f"{k} - {v['titulo']}")

    escolha = input("Escolha a consulta desejada (número): ").strip()

    if escolha not in consultas:
        print("❌ Consulta inválida.")
        return

    try:
        conn = conectar()
        df = pd.read_sql(consultas[escolha]["sql"], conn)
        print(f"\n📊 Resultado de: {consultas[escolha]['titulo']}")
        print(df)
        print("\n🪟 Abrindo interface gráfica (pandasgui)...")
        show(df)
    except Exception as e:
        print(f"❌ Erro na consulta: {e}")
    finally:
        if 'conn' in locals():
            conn.close()

if __name__ == "__main__":
    main()
