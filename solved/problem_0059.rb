require 'projectEuler'

# XOR decryption
class Problem_0059
  # Each character on a computer is assigned a unique code and the preferred
  # standard is ASCII (American Standard Code for Information Interchange).
  # For example, uppercase A = 65, asterisk (*) = 42, and lowercase k = 107.
  # 
  # A modern encryption method is to take a text file, convert the bytes to
  # ASCII, then XOR each byte with a given value, taken from a secret key. The
  # advantage with the XOR function is that using the same encryption key on
  # the cipher text, restores the plain text; for example, 65 XOR 42 = 107,
  # then 107 XOR 42 = 65.
  #
  # For unbreakable encryption, the key is the same length as the plain text
  # message, and the key is made up of random bytes. The user would keep the
  # encrypted message and the encryption key in different locations, and
  # without both "halves", it is impossible to decrypt the message.
  #
  # Unfortunately, this method is impractical for most users, so the modified
  # method is to use a password as a key. If the password is shorter than the
  # message, which is likely, the key is repeated cyclically throughout the
  # message. The balance for this method is using a sufficiently long password
  # key for security, but short enough to be memorable.
  #
  # Your task has been made easy, as the encryption key consists of three
  # lower case characters. Using cipher1.txt, a file containing the encrypted
  # ASCII codes, and the knowledge that the plain text must contain common
  # English words, decrypt the message and find the sum of the ASCII values in
  # the original text.

  WORDS = %w(the be to of and a in that have I it for not on with he as you do
             at this but his by from they we say her she or an will my one all
             would there their what so up out if about who get which go me 
             when make can like time no just him know take people into year
             your good some could them see other than then now look only come
             its over think also back after use two how our work first well
             way even new want because any these give day most us)

  def self.solve()
    orig = IO.read( 'resources/cipher1.txt' ).split( ',' ).map( &:to_i )
    repeat = 1 + orig.length / 3

    'aaa'.upto( 'zzz' ) do |key|
      pad = (key * repeat).codepoints
      plain = orig.zip( pad ).map {|pair| (pair[0] ^ pair[1]).chr}.join.split

      if 15 < (WORDS & plain).length
        puts plain.join( ' ' ).codepoints.reduce {|a, i| a + i}
        return
      end

      key.next
    end
  end
end

ProjectEuler.time do
  # 107359
  Problem_0059.solve()
end
